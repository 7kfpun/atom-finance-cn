# Finance-cn

Simple plugin for checking your stock in Atom.io editor (Money 163 (網易財經) - China, Hong Kong and US markets).

![ScreenShot](https://raw.github.com/7kfpun/atom-finance-cn/master/screenshot.gif)


## Installing

1. Go to `Atom -> Preferences...`
2. Then select the `Install` tab
3. Enter `finance-cn` in the search box

#### Using apm

```sh
$ apm install finance-cn
```

#### Install using Git

Alternatively, if you are a git user, you can install the package and keep up to date by cloning the repo directly into your `~/.atom/packages` directory.

```sh
$ git clone https://github.com/7kfpun/atom-finance-cn.git ~/.atom/packages/finance-cn
```

#### Download Manually

1. Download the files using the [GitHub .zip download](https://github.com/7kfpun/atom-finance-cn/archive/master.zip) option and unzip them
2. Move the files inside the folder to `~/.atom/packages/finance-cn`


## Usage

Display your stock watchlist in status bar.

#### Plugin settings page

To access the Finance-cn Settings:

1. Go to `Atom -> Preferences...` or `cmd-,`
2. In the `Filter Packages` type `finance-cn`

![Settings](https://raw.github.com/7kfpun/atom-finance-cn/master/settings.png)

Finance-cn has 6 settings that can be edited:

1. Display | default: `right` (right, left)
2. Format | default: `<span style="color:white">{name}</span>({type}): {price} ({percent})`
3. Refresh | default: `30` (In seconds, if zero seconds only refreshes when open/close windows or trigger refresh)
4. Scroll | default: `left` (left, right, fixed)
4. Scroll Delay | default: `85`
5. Separator | default: ` | `
6. Watchlist | default: `hkHSI,hkHSCEI,0000001,1399001,1399300,US_DOWJONES,US_NASDAQ,US_SP500`

#### Commands

The following commands are available and are keyboard shortcuts.

* `finance-cn:toggle` - Toggle - `ctrl-alt-f` `ctrl-alt-c`
* `finance-cn:refresh` - Refresh - `ctrl-alt-r` `ctrl-alt-c`


## Financial data from Money 163 (網易財經)

This plugin supports all exchanges and markets that Money 163 covers.

- For Hong Kong stock exchange, ticker should start with "hk"
  - e.g. hkHSI, hkHSCEI, hk00005
- For Shanghai stock exchange, ticker should start with "0"
  - e.g. 0000001, 0601318
- For Shenzhen stock exchange, ticker should start with "1"
  - e.g. 1399001, 1002594
- For US markets, ticker should start with "US_"
  - e.g. US_DOWJONES, US_NASDAQ, US_SP500
- For others, please refer from Money 163

#### QuoteProperty

    // Shanghai and Shenzhen stock exchange
    code
    percent
    high
    askvol3
    askvol2
    askvol5
    askvol4
    price
    open
    bid5
    bid4
    bid3
    bid2
    bid1
    low
    updown
    type
    bidvol1
    status
    bidvol3
    bidvol2
    symbol
    update
    bidvol5
    bidvol4
    volume
    askvol1
    ask5
    ask4
    ask1
    name
    ask3
    ask2
    arrow
    time
    yestclose
    turnover

    // Hong Kong stock exchange
    suspend
    share
    ask_volume
    datetime
    high
    open
    bid_volume
    percent
    low
    pe
    52low
    type
    price
    updown
    symbol
    market_capital
    schidesp
    volume
    lotsze4
    ask
    52high
    yestclose
    bid
    name
    time
    turnover

    // US markets
    yestclose
    type
    name
    updown
    symbol
    percent
    update
    52high
    high
    low
    time
    52low
    open
    price


## Related project

- [atom-finance](https://github.com/7kfpun/atom-finance): Simple plugin for checking your stock in Atom.io editor (Yahoo Finance).


## License

Released under the [MIT License](http://opensource.org/licenses/MIT).
