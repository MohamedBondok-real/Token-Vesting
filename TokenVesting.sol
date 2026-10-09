//SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

interface IERC20 {
    function transfer (address to, uint256 amount) external returns (bool);
}
contract TokenVesting {
    IERC20 public token;
    address public beneficiary;
    uint256 public cliff;
    uint256 public start;
    uint256 public duration;
    uint256 public interval;
    uint256 public totalAmount;
    uint256 public released;

    constructor (
        IERC20 _token,
        address _beneficiary,
        uint256 _start,
        uint256 _cliffDurationInMonths,
        uint256 _totalVestingDurationInMonths,
        uint256 _amount
    ){
        require (_cliffDurationInMonths <= _totalVestingDurationInMonths, "Cliff Duration Exceeds Vesting Duration");
        require (_totalVestingDurationInMonths > 0, "Vetsing Duration Must Be Positive");
        require (_amount > 0, "Amount Must Be Greater Than 0");

        token = _token;
        beneficiary = _beneficiary;
        start = _start;
        interval = 90 days;
        duration = _totalVestingDurationInMonths * 30 days;
        cliff = _start + (_cliffDurationInMonths * 30 days);
        totalAmount = _amount;
    }

    function release () public {
        require (block.timestamp > cliff , "Cliff Period Is Not Finished Yet");
        uint256 unreleased = releasableAmount();
        require (unreleased > 0, "No Tokens Are Due For Release");

        released += unreleased;
        token.transfer(beneficiary, unreleased);
    }

    function releasableAmount() public view returns (uint256) {
        return vestedAmount() - released;
    }

    function vestedAmount() public view returns (uint256) {
        if (block.timestamp < cliff){
            return 0;
        }
        else if (block.timestamp >= cliff){
            return totalAmount;
        }
        else {
            uint256 timeFromStart = block.timestamp - start;
            uint256 totalIntervals = timeFromStart/interval;
            uint256 totalVestingIntervals = duration/interval;

            return (totalAmount * totalIntervals) / totalVestingIntervals;
        }
    }
}
