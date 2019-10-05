# Test suits for Municipality result
# Function to be tested
context("MunicipalityResults")

# Test that function take available municipality name 
test_that("found invalid county name", {
  expect_error(MunicipalityResults(Municipality_name = "Abcd"))
  expect_error(MunicipalityResults(Municipality_name = ""))
})

# test that no special characters in the municipality name
test_that("Found special characters",{
  expect_error(MunicipalityResults(Municipality_name = "Nai#&%"))
  expect_error(MunicipalityResults(Municipality_name = "123"))
}
)