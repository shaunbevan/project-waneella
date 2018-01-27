pragma solidity ^0.4.18;

/// @title Access Control
contract AccessControl {
    
    /// @dev The addresses that have access control to certain contract functions.
    address public grandmasterAddress;
    address public masterAddress;
    
    /// @dev Keeps track of whether or not the contract is paused.
    bool public paused = false;
    
    /// @dev Access modifier for grandmaster-only functions.
    modifier onlyGM() {
        require(msg.sender == grandmasterAddress);
        _;
    }
    
    /// @dev Access modifier for master-only functions.
    modifier onlyMaster() {
        require(msg.sender == masterAddress);
        _;
    }
    
    /// @dev Access modifier for master-level functions.
    modifier onlyMasterLevel() {
        require(msg.sender == grandmasterAddress || msg.sender == masterAddress);
        _;
    }
    
    /// @dev Sets a new grandmaster.
    /// @param _newGrandmaster is the new address of the grandmaster.
    function setGrandmaster(address _newGrandmaster) public onlyGM {
        require(_newGrandmaster != address(0x0));
        grandmasterAddress = _newGrandmaster;
    }
    
    /// @dev Sets a new master.
    /// @param _newMaster is the new address of the master.
    function setMaster(address _newMaster) public onlyMaster {
        require(_newMaster != address(0x0));
        masterAddress = _newMaster;
    }
    
    /*** Pausable functionality adapted from OpenZeppelin ***/

    /// @dev Modifier to allow actions only when the contract IS NOT paused
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /// @dev Modifier to allow actions only when the contract IS paused
    modifier whenPaused {
        require(paused);
        _;
    }

    /// @dev Called by any "Master" role to pause the contract. Used only when
    ///      a bug or exploit is detected and we need to limit damage.
    function pause() public onlyMasterLevel whenNotPaused {
        paused = true;
    }

    /// @dev Unpauses the smart contract. Can only be called by the GM, since
    ///  one reason we may pause the contract is when the master account is
    ///  compromised.
    function unpause() public onlyGM whenPaused {
        // can't unpause if contract was upgraded
        paused = false;
    }
}