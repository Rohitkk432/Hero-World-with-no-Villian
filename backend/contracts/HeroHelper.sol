// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./HeroFactory.sol";

/// @title Helper Functions
/// @author Rohit Kodam
/// @notice Purchases and get functions.
contract HeroHelper is HeroFactory {
    ///@notice fees for specific tasks.
    uint256 levelUpFee = 0.001 ether;
    uint256 CardPurchaseFee = 0.002 ether;

    ///@notice withdraws the balance of the contract.
    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    ///@notice sets fees.
    function setLevelUpFee(uint256 _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    function setCardPurchaseFee(uint256 _fee) external onlyOwner {
        CardPurchaseFee = _fee;
    }

    ///@notice levels up the hero
    function levelUp(uint256 _HeroId) external payable {
        require(msg.value == levelUpFee);
        heroes[_HeroId].level++;
    }

    ///@notice purchases a summonCard.
    function purchaseCard() external payable {
        require(msg.value == CardPurchaseFee);
        _generateRandomSummonCard();
    }

    ///@notice gets all heroes by a owner.
    function getHeroesByOwner(address _owner)
        external
        view
        returns (uint256[])
    {
        uint256[] memory result = new uint256[](ownerHeroCount[_owner]);
        uint256 counter = 0;
        for (uint256 i = 0; i < heroes.length; i++) {
            if (heroToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    ///@notice gets all cards by a owner.
    function getCardsByOwner(address _owner) external view returns (uint256[]) {
        uint256[] memory result = new uint256[](ownerSummonCardCount[_owner]);
        uint256 counter = 0;
        for (uint256 i = 0; i < summonCards.length; i++) {
            if (summonCardToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}