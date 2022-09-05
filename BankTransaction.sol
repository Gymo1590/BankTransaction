//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract BankTransaction{

 address owner;
 mapping(address => uint) public balances;
 struct Transaction{
     bytes32 paymentID;
     address clientID;
     address recipientID;
     uint amount;
     uint date;
     string note;
 }
 mapping (address=>Transaction) public records;
    mapping(bytes32=> address) getPaymentID;

 constructor(){
     owner= msg.sender;
 }

 function new_payment(  address _receiver, uint _amount,string memory _note) 
 public payable {
    require(balances[owner]>= _amount, "Not enough ether");
    balances [owner] -= _amount;
    (bool sent,) = owner.call{value:_amount}("ether sent");
    require(sent, "not enough ether");
    bytes32  paymentID = keccak256(abi.encodePacked(bytes32(bytes20(owner)),bytes32(bytes20(_receiver)),bytes32(block.timestamp),bytes32(_amount)));
    Transaction memory newTransaction = Transaction(paymentID,owner,_receiver,_amount,block.timestamp,_note );
    records[owner] = newTransaction;
    //the code below will help us to search a contract by payment id since in solidity mapping you can only search for the key and not value
    getPaymentID[paymentID] = owner;
 }

 function paymentByClientId(address _clientID) public view 
 returns (bytes32 ,address ,address ,uint ,uint  ,string memory ){
     Transaction memory  transact = records[_clientID];

     return (transact.paymentID,transact.clientID,transact.recipientID,transact.amount,transact.date,transact.note);
 }

 function paymentByID(bytes32  payment_ID) public view
  returns(bytes32 ,address ,address ,uint ,uint  ,string memory ){
      //the code below extracts the address pertaining the payment id entered
   address  _clientID  = getPaymentID[payment_ID];

      Transaction memory  transact = records[_clientID];
      return (transact.paymentID,transact.clientID,transact.recipientID,transact.amount,transact.date,transact.note);
      
 }

}
