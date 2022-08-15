## **STA 380, Part 2: Exercises**

## Probability Practice

### **Part a**

### **Part b**

## Wrangling the Billboard Top 100

### **Part a**

### **Part b**

### **Part c**

## Visual story telling part 1: green buildings

### **Problem**

An Austin real-estate developer is interested in the possible economic
impact of “going green” in her latest project: a new 15-story mixed-use
building on East Cesar Chavez, just across I-35 from downtown. Will
investing in a green building be worth it, from an economic perspective?
The baseline construction costs are $100 million, with a 5% expected
premium for green certification.

The developer has had someone on her staff, who’s been described to her
as a “total Excel guru from his undergrad statistics course,” run some
numbers on this data set and make a preliminary recommendation. Here’s
how this person described his process:

> I began by cleaning the data a little bit. In particular, I noticed
> that a handful of the buildings in the data set had very low occupancy
> rates (less than 10% of available space occupied). I decided to remove
> these buildings from consideration, on the theory that these buildings
> might have something weird going on with them, and could potentially
> distort the analysis. Once I scrubbed these low-occupancy buildings
> from the data set, I looked at the green buildings and non-green
> buildings separately. The median market rent in the non-green
> buildings was $25 per square foot per year, while the median market
> rent in the green buildings was $27.60 per square foot per year: about
> $2.60 more per square foot. (I used the median rather than the mean,
> because there were still some outliers in the data, and the median is
> a lot more robust to outliers.) Because our building would be 250,000
> square feet, this would translate into an additional $250000 x 2.6 =
> $650000 of extra revenue per year if we build the green building.

> Our expected baseline construction costs are $100 million, with a 5%
> expected premium for green certification. Thus we should expect to
> spend an extra $5 million on the green building. Based on the extra
> revenue we would make, we would recuperate these costs in
> $5000000/650000 = 7.7 years. Even if our occupancy rate were only 90%,
> we would still recuperate the costs in a little over 8 years. Thus
> from year 9 onwards, we would be making an extra $650,000 per year in
> profit. Since the building will be earning rents for 30 years or more,
> it seems like a good financial move to build the green building. Goal:
> The developer listened to this recommendation, understood the
> analysis, and still felt unconvinced. She has therefore asked you to
> revisit the report, so that she can get a second opinion.

## Exploratory Data Analysis

it may seem like the stats guru is on point with their analysis upon
first glance when using the same assumption and removing the rows with
occupancy rates lower than 10%, the green buildings still average $2.6
dollars more per square foot.

    ## # A tibble: 2 × 3
    ##   green_rating med_rent count
    ##   <fct>           <dbl> <int>
    ## 1 0                25.0  6995
    ## 2 1                27.6   684

While looking at the box plot we see that the non-green buildings have a
fair amount more outliers, which explains the guru’s reasoning for using
the median as opposed to the mean.
![](Final-Submission_files/figure-markdown_strict/unnamed-chunk-5-1.png)
