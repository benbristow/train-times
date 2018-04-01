# Train Times

[![Build Status](https://travis-ci.org/benbristow/train-times.svg?branch=master)](https://travis-ci.org/benbristow/train-times)

![image](https://user-images.githubusercontent.com/1159378/36936548-f60a8ae0-1efe-11e8-8cec-afec838605c9.png)

```
➜  train-times git:(master) ✗ tt departures glc   
+-------+-----------+-------+-----------------------+---------------------+
| Time  | Estimated | Plat. | Origin                | Destination         |
+-------+-----------+-------+-----------------------+---------------------+
| 19:21 | Delayed   | N/S   | Glasgow Central (GLC) | Lanark (LNK)        |
| 19:24 | On time   | 17    | Cumbernauld (CUB)     | Dalmuir (DMR)       |
| 19:25 | On time   | 12R   | Glasgow Central (GLC) | Gourock (GRK)       |
| 19:27 | 19:29     | 16    | Dalmuir (DMR)         | Motherwell (MTH)    |
| 19:28 | 19:31     | 17    | Whifflet (WFF)        | Dalmuir (DMR)       |
| 19:30 | On time   | 13R   | Glasgow Central (GLC) | Ayr (AYR)           |
| 19:33 | On time   | 11F   | Glasgow Central (GLC) | Kilmarnock (KMK)    |
| 19:34 | 19:46     | 16    | Milngavie (MLN)       | Motherwell (MTH)    |
| 19:35 | On time   | 8R    | Glasgow Central (GLC) | Neilston (NEI)      |
| 19:36 | On time   | 14R   | Glasgow Central (GLC) | Wemyss Bay (WMS)    |
| 19:40 | On time   | 17    | Larkhall (LRH)        | Milngavie (MLN)     |
| 19:42 | On time   | 15R   | Glasgow Central (GLC) | Paisley Canal (PCN) |
| 19:45 | On time   | N/S   | Glasgow Central (GLC) | Largs (LAR)         |
| 19:45 | On time   | 10R   | Glasgow Central (GLC) | Newton (NTN)        |
| 19:46 | On time   | N/S   | Ayr (AYR)             | Edinburgh (EDB)     |
+-------+-----------+-------+-----------------------+---------------------+
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
./main.rb departures ORIGIN [DESTINATION]
```

* ORIGIN: Where the train is departing from

* DESTINATION (optional - leave blank for anywhere): Where the train is going - this can be anywhere the train stops down the line

### Arrivals

```
./main.rb arrivals ARRIVING [FROM]
```

* ARRIVING: Where the train is arriving at

* FROM (optional - leave blank for all): Where the train is coming from before it arrives - this can also be anywhere the train stops down the line

### Service details

```
./main.rb details SERVICE_ID
```

* SERVICE_ID: The ID of the service. This can be retrieved from departures/arrivals.

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
