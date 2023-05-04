# Introduction
We have created a powerful tool that provides support when trading in the Japanese stock market. This tool will help you reduce the tedious work involved in trading.

## Current Features
・Trading volume ranking: You can copy up to 50 companies' stock codes from the top 200 trading volume ranking of the day to the clipboard. This will enable you to easily find companies to invest in by pasting the copied stock codes into your trading tool.

・Financial report company list: You can copy up to 50 companies' stock codes from the list of companies that have a financial report due in 3 weeks to the clipboard. This will enable you to easily find companies to invest in by pasting the copied stock codes into your trading tool.

## Future Improvements
・New high price list feature: A function to obtain a list of companies that reached a new high on the day of trading.

・Financial report company list from calendar: A function to obtain a list of companies with financial reports from a calendar.

## Technology Stack
・Ruby 3.0.5

・Rails 7.0.3

・MySQL 5.7

・RSpec

・Docker

## How to Use
You can set up the environment using Docker. Please use Docker Compose to build the database and application containers.

## Notes on Usage
Please note that this application uses scraping technology to obtain data for some of its features. Scraping is a technique that may put a heavy load on the source server. Please refrain from accessing it excessively.
