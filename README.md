# OnePlusOne
### Instructions:
1. Navigate to [http://oneplusone-njl.herokuapp.com/](http://oneplusone-njl.herokuapp.com/)
2. Log in with the test account, email= 'gibbons@initech.com', password = 'tpsreports1999'
3. Or create new account.

### Design Decisions

#### Organizations
* Custom Sessions and authorization. (Devise or something seemed like overkill)
* Authorization: All interaction with an Organization or its members, (People, Teams) is authorized by a custom before_filter.
* Forgot Passoword?: Organization enters their email, unique token generated, stored in DB. Send email with link containing token. When link is navigated to, checks if token has expired, otherwise lets Organization reset password.

#### Team Management
* Interaction-Heavy, reloading page for requests would be heinous!
* Used Unobtrusive Javascript pattern to return server-rendered html to inject in the page with jQuery.


#### Pairing Algorithm
* The pairing algorithm I designed is inspired by the so-called marriage or secretary problem. It adds an additional ranking that maximizes the number of pairs.

* http://en.wikipedia.org/wiki/Secretary_problem

* Steps:


1. Calculate the potential partners for each Person. Will be a Hash[person_id] which stores another Hash[partner_id] as its value. ex. {3:{7:true,9:true...}...}
2. Sort People by the number of their potential partners, from least to greatest. This will be our processing queue.
3. The Person at the front of this queue will get choose to his favorite mate. (Favorite being an eligible person he has paired the least with in the last 10 weeks). All we have to do is lookup the list of eligable mates from the Hash we created, calculate the amount of times this person has paired with the mate in the past, and choose the potential mate with the least amount of past pairings.
4. Pair is created. Remove these two People from our Hash, recalculate our processing queue, and repeat until there is < 2 people left.

* Algorithm maximizes the number of people who participate in 1+1s by pairing the people with few potential pairs first.
* Algorithm results in even distribution through pairing people with their least paired with teammate.

###Testing
Testing was done using rspec and capybara. I focused on testing 'end-to-end' features rather than individual route, resource, view, or model tests. I mostly conformed to test-driven develepment, writing tests before implementation, and capybara testing allowed me to think in terms of features and user interaction before implementation.