# NewsApp

In this tutorial you will learn how to get full advantages of NewsApp step by step.

## Get Started

First go to: https://newsapi.org
then create your own API Key.
then open XCode project
navigate to `RequestConstants` file then set `apiKey` variable to your own key.
Now you are ready to run the app.

## Onboarding
You should see the Onboarding screen, like the following:
![](/DocumentationAssets/Onboarding.png)

### Selecting Country
You should select The Country you prefer to get it's latest news.

When you click on country text field, you will show a picker view contains all countries supported by our App to choose from them.

### Selecting Categories
After that you should select only 3 categories you prefer to get their related news.

Click on Start Button, if all went well you should be navigated successfully to the Dashboard.

## Dashboard
In Dashboard you will see latest news headlines, something like this:
![](/DocumentationAssets/Dashboard.png)

### Dashboard Screen Content
The Dashboard screen have the following items:
- Articles cards with add to favorites button to be read later
- Search bar
- Two tabs at the bottom of screen `Home` and `Favorites`.

### Articles Cards
The card contains the title, image and short description, to see full article you should click on the card and you will be navigated to safari with the full details related to this article.

also, you can add this article to favorites by tapping on the button in the very bottom section of the card, like the following:
![](/DocumentationAssets/DashboardFavorites.png)

### Search bar
At the very top of Dashboard there is a searchBar allows to to search any article with a specific keyword, you will need to type as many words as you want then click on search button on the keyboard to see the results, like the following:
![](/DocumentationAssets/DashboardSearch.png)

### Bottom Tabs
At the bottom of Dashboard you will see two tabs to control presented news, `Home` tab is selected by default.
When you select `Favorites` tab you will only see the news that you marked as a favorites, like this:
![](/DocumentationAssets/DashboardFavoritesTab.png)
