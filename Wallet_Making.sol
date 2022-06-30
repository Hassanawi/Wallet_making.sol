// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.7 <0.9.0;

contract Wallet_Making{

    event Deposit (address deposit_address , uint amount ,uint balance);
    event Withdraw ( uint amount , uint balance);
    event Transfer (address to , uint amount , uint balance);

    
    function deposit ()public payable{
        require (msg.value>0," Send more ether ");
        emit Deposit( msg.sender, msg.value, address(this).balance);
    }

    address payable owner;

    constructor (){
        owner=payable(msg.sender);
    }
    modifier only_owner() {
        require (msg.sender==owner, "you are not owner of account");
        _;
    }

    function withdraw(uint _amount) public only_owner{
        owner.transfer(_amount);
        emit Withdraw(_amount,address(this).balance);
    }

    function transfer( address payable _to ,uint  _amount )public only_owner{
        _to.transfer(_amount);
        emit Transfer(_to ,_amount, address(this).balance);
    }

}
