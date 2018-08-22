pragma solidity ^0.4.17;

import "zeppelin/contracts/ownership/Ownable.sol";
import "zeppelin/contracts/ownership/Contactable.sol";

contract Orders is Contactable {

    struct Order {
        bool exists;
        address owner;
        string country;
        string zip;
        string text;
        bool completed;
        uint price;
        uint index;
    }

    Order[] private orders;

    constructor() public {
        setContactInformation("You can contact me on https://github.com/d0x or https://twitter.com/chrschneider");
    }

    function insert(string country, string zip, string text, uint price)
    public
    returns (uint index)
    {
        Order memory newOrder;
        newOrder.owner = msg.sender;
        newOrder.exists = true;
        newOrder.text = text;
        newOrder.country = country;
        newOrder.zip = zip;
        newOrder.completed = false;
        newOrder.price = price;

        index = orders.push(newOrder) - 1;
        newOrder.index = index;
        return index;
    }

    function buy(uint index)
    payable
    public {
        require(!orders[index].completed, "Order is already completed");
        require(orders[index].exists, "Invalid order index");
        // todo require enough money

        orders[index].owner.transfer(msg.value);
        orders[index].completed = true;
    }

    function close(uint index)
    public {
        require(!orders[index].completed, "Order is already completed");
        require(orders[index].exists, "Invalid order index");
        require(orders[index].owner == msg.sender, "Only owner can close orders");

        orders[index].completed = true;
    }

    function get(uint index)
    public
    constant
    returns (address owner, string country, string zip, string text, bool completed, uint price){
        require(orders[index].exists, "Invalid order index");

        Order memory order = orders[index];

        return (order.owner, order.country, order.zip, order.text, order.completed, order.price);
    }

    function getCount()
    public
    constant
    returns (uint count)
    {
        return orders.length;
    }

}
