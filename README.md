# Airplane booking system

Badi flight company needs to add a booking system to the current application.

Currently the Badi fleet is composed only by a short range plane that has the following characteristics:

| Aircraft Type | Sits Count  | Rows        | Row Arrangement          |
|---------------|-------------|-------------|--------------------------|
| :short_range  | 156         | 26          | A B C _ D E F            |


The service:

- Doesn't have any database support.
- Should be designed to expose an interface that allows separate components to interact with it.

The API should support a multiple seats booking, expecting the name of the passenger and the number of places to book (up to 8). As result it will return the positions of all the places booked.

The booking logic has the following rules:

1) If the places can all fit on a row without crossing the aisle, they will be booked in the same row. _(ex. ['A1', 'B1', 'C1'] or ['E1', 'F1'])_
2) If the places don't fit on a row without crossing the aisle, they will be balanced across rows. _(ex. ['A1', 'B1', 'A2', 'B2'])_
3) If there are not available places and the seats cannot be arranged all across rows, they will be booked to be nearby across the aisle. _(ex. ['C1', 'D1', 'C2', 'D2'])_
4) If none of the above rules are appliable, position the seat on a random place.
5) The booking should start from the window seats, when possible.


Here you can find an interface example:
```ruby
booking = Booking.new(plane)

booking.book('Marco', 4)
booking.book('Gerard', 2)

booking.show
```

Given an empty plane, those are the expected behaviours.
```
Bookings:
  * Marco: 4 people;
  * Gerard: 2 people;
Result:
  * Marco seats: 'A1', 'B1', 'A2', 'B2';
  * Gerard seats: 'E1', 'F1';

Bookings:
  * Iosu: 2 people;
  * Oriol: 5 people;
  * David: 2 people;
Result:
  * Iosu seats: 'A1', 'B1';
  * Oriol seats: 'D1', 'E1', 'F1', 'E2', 'F2';
  * David seats: 'A2', 'B2';

Bookings:
  * Iosu: 2 people;
  * Gerard: 2 people;
Result:
  * Iosu seats: 'A1', 'B1';
  * Gerard seats: 'E1', 'F1';
```

You should:

- Add information about your design decision.
- Write production-ready code.
- Design the code in order to be extensible.
- Suggest possible enhancements.
- Provide the source code with all the git history and the description about how to execute the code.
