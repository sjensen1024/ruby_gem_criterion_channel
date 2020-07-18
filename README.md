# ruby_gem_criterion_channel

**Important Note Before Installing:** Please be aware that this is an unofficial build and was not built in partnership with the Criterion Channel or any of its affiliates. Because of the current lack of an API, this gem parses the site's HTML to get the infomration about the films. Therefore, if the Criterion Channel's HTML or design changes, this gem may stop working. Also, while the list of films is available to the public, you cannot watch the films without an account.

## What is this gem? Why would you want to use it?
The criterion_channel gem pulls information from the Criterion Channel website's current list of films and returns it to you as an object that you can use in your Ruby code. As stated in the note above, this was more of a personal "for fun" project than something that is widely distributable. However, you could use it to have your own application perform a search for films that are on the Criterion Channel, directors with films on the channel, look at all of the films on the site for a particular country, etc.

## What happens when you create a new instance of CriterionChannel? What are its attributes?
The gem pulls data from the Criterion Channel's current film list. Once it gets this information, it sets up an instance with two parts:
* **films**: an array of Film objects based on data pulled from the site
* **data_pull_time**: the time at which the pull occurred

### What are the attributes of a Film?
* **country**: the country of origin of the film
* **director**: the name of the film's director
* **img**: the link to the poster of the film on the Criterion Channel website
* **title**: the title of the film
* **year**: the year of the film's release
