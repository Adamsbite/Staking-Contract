//SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface IStandardToken {
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function withdrawEther() external;
}

contract StakingContract{
    IStandardToken standardToken;
struct User{
    uint amountStaked;
    uint timeStaked;
}
mapping (address => User) user;

event Staked(uint amountstake, uint totalAmountStaked, uint time);

constructor(address _standardToken){
    standardToken = IStandardToken(_standardToken);
}
    function stake(uint amount) external {
        uint balance = standardToken.balanceOf(msg.sender);
        require(balance >=  amount, "ERC20 insuficient balance");
        bool status = standardToken.transferFrom(msg.sender, address(this), amount);
        require(status == true, "transfer Failed");
        User storage _user = user[msg.sender];
        _user.amountStaked += amount;
        _user.timeStaked = block.timestamp;
        emit Staked(amount, _user.amountStaked, block.timestamp);
    }

    function getStakeAmount(address who) public view returns(uint _staked){
        User storage _user = user[who];
      _staked = _user.amountStaked;
    }

    function withdraw(uint amount) external{
         uint totalStaked = getStakeAmount(msg.sender);
         require(totalStaked >= amount, "insufficent stake amount");
         User storage _user = user[msg.sender];
         _user.amountStaked -= amount;
         standardToken.transfer(msg.sender, amount);

    }

    function withdrawEther()  external{
        standardToken.withdrawEther();
        payable(msg.sender).transfer(address(this).balance);


    }
    receive() external payable{}
    fallback() external payable{}
}
