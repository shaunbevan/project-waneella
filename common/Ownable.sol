pragma solidity ^0.4.13;

/**
 * @title Ownable contract - base contract with an owner.
 */
contract Ownable {
  address public owner;
  modifier onlyOwner() {
      /// Check that sender is owner of contract.
      require(msg.sender == owner);
      _;
  }

  // Constructor

  function Ownable() 
    public 
  {
      owner = msg.sender;
  }

  // Public functions

  function transferOwnership(
    address newOwner
  ) 
    onlyOwner 
    public 
  {
    if (newOwner != address(0)) {
      owner = newOwner;
    }
  }
}