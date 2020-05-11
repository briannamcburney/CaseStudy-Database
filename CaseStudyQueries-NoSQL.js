db.customer.insertMany([
    { 
        custID: 1
        name:"Artur",
        address: "1234 someStreet",
        city: "Oakville",
        state: "Ontario",
        postalCode: "G6S9F4",
        telephoneWork: 4123412341,
        telephoneHome: 8926352842
    },{
        custID: 2,
        name:"Brianna",
        address: "6578 otherRoad",
        city: "Oakville",
        state: "Ontario",
        postalCode: "H9G6D4",
        telephoneWork: 6381548273,
        telephoneHome: 2816493092,
    }
])
db.Car.insertMany([
    {
        serialNo:4123,
        tradeInStatus:"false",
        model: 871
    },{
        serialNo:5623,
        tradeInStatus:"true",
        model:231
    }
])
db.Model.insertMany([
    {
        id:871,
        make:"BMW",
        model:"328i",
        color: "white",
        upholsteryStyle: "leather",
        year: "2015"
    },{
        id:231,
        make:"Chevrolet",
        model:"Malibu",
        color: "blue",
        upholsteryStyle: "regular",
        year: "2013"
    }
])