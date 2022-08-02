// SPDX - License -Identifier: MIT

pragma solidity ^0.8.0;

contract FlatRent {

    address private landlord;
    address private tenant;
    uint private createdTimeStamp;
    uint private deadline;


    function provideFlat() public {
        landlord = msg.sender;
    }

    function confirmRent() public {
        if (msg.sender != landlord) {
            tenant = msg.sender;
            createdTimeStamp = block.timestamp;
        }
    }

    function payRent() payable public {
        if (msg.sender != landlord && msg.value >= 300 && block.timestamp <= deadline ) {
            transferTo(landlord, 300);
            deadline = block.timestamp + 30 days;
        }
    }

    function terminateContract() payable public {
        if (msg.sender == landlord && msg.value >= 1000) {
            transferTo(tenant, 1000);
        }
    }

   function transferTo(address targetAddress, uint amount) private {
        address payable _to = payable(targetAddress);
        _to.transfer(amount) ;
    }
}
