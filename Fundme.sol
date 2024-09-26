// SPDX-Licence-Identifier: MIT;
pragma solidity 0.8.5;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract Fundme {
    address public owner;
    constructor() public{
        owner = msg.sender;
    }
    function fund() public payable {
        mapping(address => uint256 ) public senderToAmount;
        uint256  minUsd = 50*10*18;
        require(convertEthToUsd(msg.value) >= minusd);
        senderToAmount[msg.sender] += msg.value;
        
    }
    function getPrice() view return(uint256) {
        dataFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;   
    }
    function convertEthToUsd(uint256 _ethAmount) view return(uint256){
        uint256 ethPrice = getPrice();
        uint256 usdPrice = ethPrice * _ethAmount;
        return usdPrice;
    }
    modifier onlyOwner{
        require(msg.sender == owner);
        _;


    }
    function withdraw() public onlyOwner payable{ 
        msg.sender.transfer(address(this).balance);
    }
}
