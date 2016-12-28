# Ruby on Rails HipsterGram

InstaGram clone. See this app live at: https://stefangram.herokuapp.com/

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rspec
```
Note: there are some issues with the test syntaxes and depreciation, but technically all the tests pass.
If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

![HipsterGram](https://raw.githubusercontent.com/StefanRudvin/HipstergramBDD/master/Photogram.png)
