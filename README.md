# Train Times

[![Build Status](https://travis-ci.org/benbristow/train-times.svg?branch=master)](https://travis-ci.org/benbristow/train-times)

![image](https://user-images.githubusercontent.com/1159378/36936548-f60a8ae0-1efe-11e8-8cec-afec838605c9.png)

```
➜  train-times git:(master) ✗ tt departures pyg glc
+-------+-----------+-------+-------------------------+-----------------------+--------------------------+
| Time  | Estimated | Plat. | Origin                  | Destination           | ID                       |
+-------+-----------+-------+-------------------------+-----------------------+--------------------------+
| 17:41 | On time   | 3     | Ayr (AYR)               | Glasgow Central (GLC) | +OU53q+tcoD3unG+zNC/Fg== |
| 17:43 | On time   | 1     | Gourock (GRK)           | Glasgow Central (GLC) | RHYNXEhUBkZTytzQIhXqpA== |
| 17:52 | On time   | 1     | Gourock (GRK)           | Glasgow Central (GLC) | h+ZNl7DkOyPK0Xh0uW5Nog== |
| 17:55 | On time   | 3     | Ayr (AYR)               | Glasgow Central (GLC) | mMgeaMkpVrMbrj27nYA82Q== |
| 17:59 | On time   | 3     | Ardrossan Harbour (ADS) | Glasgow Central (GLC) | 3WA6yAC7OCVOcHEp39a/Sg== |
| 18:06 | On time   | 3     | Ayr (AYR)               | Glasgow Central (GLC) | 5UZrjQvfBjnOJKzwMcLh7A== |
| 18:18 | On time   | 1     | Gourock (GRK)           | Glasgow Central (GLC) | OKjbKQuaFc31q81Lxajg2w== |
| 18:25 | On time   | N/S   | Largs (LAR)             | Glasgow Central (GLC) | P136FWkdE5FC2DyPlvQtLQ== |
| 18:31 | On time   | N/S   | Ayr (AYR)               | Glasgow Central (GLC) | uyRcHyoQYn/pbEtToAVk2w== |
| 18:34 | On time   | N/S   | Wemyss Bay (WMS)        | Glasgow Central (GLC) | noxFjTZI3yPyhjCP3AWk1w== |
| 18:40 | On time   | N/S   | Ardrossan Harbour (ADS) | Glasgow Central (GLC) | bF6dDmjLsW3zRVOFaZlV6w== |
| 18:43 | On time   | N/S   | Gourock (GRK)           | Glasgow Central (GLC) | PREao7qK2Bn2WGhdhZwB8Q== |
| 18:52 | On time   | N/S   | Gourock (GRK)           | Glasgow Central (GLC) | St/sxPjHFSrikKCiHktmyg== |
| 18:55 | On time   | N/S   | Ayr (AYR)               | Glasgow Central (GLC) | 1dfvdfXuPUsOg3kAi4s/nw== |
| 19:01 | On time   | N/S   | Ayr (AYR)               | Glasgow Central (GLC) | doTivelgvl9tpA1vIkp+Ww== |
+-------+-----------+-------+-------------------------+-----------------------+--------------------------+
```

```
➜  train-times git:(master) ✗ tt details noxFjTZI3yPyhjCP3AWk1w==
+------------------------------+-----------+-----------+
| Station                      | Scheduled | Estimated |
+------------------------------+-----------+-----------+
| Wemyss Bay (WMS)             | 17:51     | 17:51     |
| Inverkip (INP)               | 17:55     | 17:55     |
| IBM (IBM)                    | 18:05     | 18:05     |
| Branchton (BCN)              | 18:08     | 18:08     |
| Drumfrochar (DFR)            | 18:10     | 18:10     |
| Whinhill (WNL)               | 18:13     | 18:13     |
| Port Glasgow (PTG)           | 18:18     | 18:18     |
| Bishopton (BPT)              | 18:27     | 18:27     |
| Paisley Gilmour Street (PYG) | 18:33     | 18:33     |
| Glasgow Central (GLC)        | 18:44     | 18:44     |
+------------------------------+-----------+-----------+
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

For all stations you'll need to know the corresponding CRS code (3 letter character code for the station). You can find these easily on something like https://www.trainline.com.

e.g.

GLC = Glasgow Central
PYG = Paisley Gilmour Street

### Departures

```
./main.rb departures ORIGIN [DESTINATION]
```

* ORIGIN: Where the train is departing from

* DESTINATION (optional - leave blank for anywhere): Where the train is going - this can be anywhere the train stops down the line

* `-t --terminating` - Show only trains that are terminating at the destination.

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
tt departures GLC PYG
```

Cool, huh?

## Running Tests

Tests use Rspec as a framework. To run the tests run:

```
rspec
```

from the root folder
