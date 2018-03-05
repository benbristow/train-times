# Train Times

[![Build Status](https://travis-ci.org/benbristow/train-times.svg?branch=master)](https://travis-ci.org/benbristow/train-times)

![image](https://user-images.githubusercontent.com/1159378/36936548-f60a8ae0-1efe-11e8-8cec-afec838605c9.png)

```
➜  train-times git:(master) ✗ ruby main.rb -a EUS
+-------+--------+----------+---------------------+---------------------+
| Time  | Status | Platform | Origin              | Destination         |
+-------+--------+----------+---------------------+---------------------+
| 01:03 | 00:51  | 14       | Wolverhampton (WVH) | London Euston (EUS) |
+-------+--------+----------+---------------------+---------------------+
```

## What?

CLI (Ruby) script to read National Rail train arrivals/departures.

Made this for myself, but putting it on here for anyone who finds this sort of thing fun/useful.

Also a basic demonstration of using the rather confusing OpenLDBW SOAP API with Ruby.

## Get Started

You need an OpenLDBW token from National Rail, register here:

https://realtime.nationalrail.co.uk/OpenLDBWSRegistration/Registration

You should have a new version of Ruby (2.5.0 recommended) and Bundler installed.

```
git clone https://github.com/benbristow/train-times.git
cd train-times
echo "NATIONAL_RAIL_TOKEN=your-token-here" > .env
bundle install
chmod +x main.rb
./main.rb
```

## Usage

For all stations you'll need to know the corrosponding CRS code (3 letter character code for the station). You can find these easily on something like trainline.com.

e.g.

GLC = Glasgow Central
PYG = Paisley Gilmour Street

### Departures

```
./main.rb ORIGIN [DESTINATION]
```

* Origin: Where the train is departing from

* Destination (optional - leave blank for anywhere): Where the train is going - this can be anywhere the train stops down the line

### Arrivals

```
./main.rb --a ARRIVING [FROM]
```

* Arriving: Where the train is arriving at

* From (optional - leave blank for all): Where the train is coming from before it arrives - this can also be anywhere the train stops down the line

### Help

```
./main.rb --help
```

## Run from anywhere

Easiest way to run this script from any directory is to create an alias. Add an alias to your `.bashrc` or `.zshrc` like:

```
alias tt="ruby ~/scripts/train-times/main.rb"
```

Then restart your terminal. You should then be able to do:

```
tt GLC PYG
```

Cool, huh?

## Running Tests

Tests use Rspec as a framework. To run the tests run:

```
rspec
```

from the root folder
