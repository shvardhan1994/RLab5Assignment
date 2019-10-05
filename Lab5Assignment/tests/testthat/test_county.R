# Test suits for county result
# Function to be tested
context("CountyResults")

# Test that function take available county name
test_that("found invalid county name", {
  expect_error(CountyResults(County_name = "ABCD"))
  expect_error(CountyResults(County_name = ""))
})

# test that no special characters or number in address
test_that("Found special characters",{
  expect_error(CountyResults(County_name = "Nai#&%"))
  expect_error(CountyResults(County_name = "123"))
}
)
