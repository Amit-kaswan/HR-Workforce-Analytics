# Data Dictionary

## Project Information

| Item | Details |
|------|---------|
| Project Name | HR Workforce Analytics Dashboard |
| Document Type | Data Dictionary |
| Version | 1.0 |

---

# Dataset Overview

This dataset contains employee information used to analyze workforce trends, employee demographics, salary distribution, and attrition.

---

# Data Dictionary

| Column Name | Data Type | Description | Example |
|-------------|-----------|-------------|---------|
| Employee_ID | Integer | Unique identifier for each employee | 1001 |
| Employee_Name | Text | Employee full name | John Smith |
| Gender | Text | Employee gender | Male |
| Age | Integer | Employee age in years | 32 |
| Department | Text | Department where the employee works | Finance |
| Job_Role | Text | Employee designation | Financial Analyst |
| City | Text | Employee work location | Noida |
| Salary | Decimal | Monthly salary | 65000 |
| Experience | Decimal | Total years of experience | 6.5 |
| Attrition | Text | Indicates whether the employee left the company | Yes / No |
| Joining_Date | Date | Employee joining date | 15-Jan-2021 |

---

# Data Quality Checks

The following checks were performed before analysis:

- Verified missing values.
- Removed duplicate records.
- Validated data types.
- Checked row consistency.
- Verified values before SQL analysis.

---

# Notes

This document serves as a reference for understanding the dataset used throughout the HR Workforce Analytics project.
