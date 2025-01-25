# README
# Patient Management System

## Overview

The goal of this project is to build an interface for a provider to be able to log in, create patients, view patients, and see which patients are relevant "soon". "Soon" means they have an appointment that is within the next 72 hours.

## Features

- **Patients Index Page**: View all patients in the system.
- **Soon Patients**: View "soon" patients with upcoming appointments based on a user-specific threshold (e.g., 3 days, 5 days, etc.).
    - Each user can define their own concept of "soon" by setting the number of upcoming days they consider relevant.
        For example:
        User A might define "soon" as 3 days.
        User B might define "soon" as 5 days.
        The "soon" filter dynamically adjusts based on the current user's preference.
    - TODO: add user profile page for updating this info.

- **Search Bar**: Filter results based on name or email.
- **Patient Creation Page**: Create a new patient.
- **Edit Patient Information**: Edit existing patient details.

## Patient Information Details

- First name (required)
- Last name (required)
- Email (required, unique)
- Next Appointment Date (optional)

## Requirements

- Ruby 3.1.3

## Setup

1. **Clone the repository**:
    ```sh
    git clone https://github.com/rhunal/patient-management
    cd patient-management
    ```

2. **Install dependencies**:
    ```sh
    bundle install
    ```

3. **Setup the database**:
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. **Run the server**:
    ```sh
    rails server
    ```

5. **Run tests**:
    ```sh
    rspec
    ```

## Usage

- Navigate to `http://localhost:3000` to access the application.
- You can use seeds.rb to create sample data on local development testing.
- Use the search bar to filter patients by name or email.
- Click "Add New Patient" to create a new patient.
- Click "View" or "Edit" to view or edit patient details.
- Use the "Soon" checkbox to filter patients with upcoming appointments.

## Notes

- Pagination is implemented with a limit of 5 patients per page. It can be changed in PatientsController#index by changing size here: `.per(5)`
- Error messages are displayed if a new patient is added with an existing email or if an email is edited to match another existing patient.

## Testing

- The project includes RSpec tests for models.
- To run the tests, use the command `rspec`.

## Contributing

- Fork the repository.
- Create a new branch (`git checkout -b feature-branch`).
- Commit your changes (`git commit -am 'Add new feature'`).
- Push to the branch (`git push origin feature-branch`).
- Create a new Pull Request.

## License

This project is licensed under the MIT License.
