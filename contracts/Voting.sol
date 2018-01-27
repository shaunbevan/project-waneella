pragma solidity ^0.4.18;

import "../common/AccessControl.sol";
import "./contracts/ERC721Token.sol";

/// @title Hex Color Voting
/// @dev Only holders of the color token can propose hex colors
///      or vote on proposed colors.
contract Voting is AccessControl {

    uint public debatingPeriodInMinutes;
    uint public numberOfColors;
    ERC721Token public tokenAddress;

    struct HexColorProposal {
        string[] hexColors;
        uint votingDeadline;
        uint numberOfVotes;
        Vote[] votes;
    }

    struct Vote {
        bool inSupport;
        address voter;
    }

    /// @dev Modifier that requires only token holders to vote
    ///      and create new color proposals.
    modifier onlyTokenHolders {
        require(tokenAddress.balanceOf(msg.sender) > 0);
        _;
    }

    /// Constructor Function
    function Voting() {

    }

    


}