//SPDX-Licence-identifier:MIT
// pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
contract  division  {
   
    function div(uint decimalPlaces) public pure returns(string memory res){

         uint a=3;
         uint b=2;
         uint factor  = 10**decimalPlaces;
         string memory answer=Strings.toString(a/b); 
         string memory remainder = Strings.toString((factor*a/b )% factor);

        res = string(abi.encodePacked(answer, '.', remainder));
        return (res);

     
    }

}
