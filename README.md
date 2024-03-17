## Execution of Upgrade/Fix Scripts in Production Environment

### Steps

1. **Clone the Database Repository**
   
   This step involves making a copy of the remote database repository on your local machine. This is done using the `git clone` command followed by the URL of the repository. The URL in your case is `git@github.com:kodecraft-pau/database.git`.

   ```bash
   git clone git@github.com:kodecraft-pau/database.git # this is just a sample database repository
   ```
2. **Navigate to the Upgrade-Scripts Directory**
   
   After cloning the repository, you need to navigate to the `upgrade-scripts` directory within the cloned repository. This is where you'll be placing your upgrade or fix scripts. The cd command is used to change directories in a Unix-like operating system.

   ```bash
   cd database/upgrade-scripts
   ```
3. **Create a New Branch for the Ticket**

   Before creating your script, create a new branch for the ticket. This helps isolate your changes and makes the review process easier. The `git checkout -b` command is used to create and switch to a new branch. The branch name should be descriptive of the task or ticket.

   ```bash
   git checkout -b bug/ticket-<number> # this is just a sample branch name
   ```
   Replace `<number>` with the actual ticket number.

   
4. **Create Your Upgrade/Fix Script**
   
   In this step, you'll create a SQL script that either upgrades a part of the database or fixes an issue. The script should be placed in the `upgrade-scripts` directory. The naming convention for the script is important for tracking and order of execution purposes. The format is `<ticket#>_<sequence>_<table-name>.sql`, where:
   * `ticket#` is the number of the ticket in Github related to this change.
   * `sequence` is a number used when multiple scripts need to be run in a specific order.
   * `table-name` is the name of the database table that the script will be applied to.
  
5. **Script Content**

   The content of the script should follow a specific format as shown below. After the script is run, a record should be inserted into the `upgrade_script` table. This is for auditing purposes and should include:
   * `name`: the filename of the SQL script.
   * `description`: a brief description of what the script does.
   * `user_created`: the username of the person who will execute the script. This could also be the author of the script, depending on the discussion.

   Example:
   ```sql
   -- Start a transaction explicitly
   BEGIN;

   -- SQL statements to be executed within the transaction
   CREATE TABLE test_table (
       id SERIAL PRIMARY KEY,
       name VARCHAR(50)
   );

   INSERT INTO public.upgrade_script (name, description, user_created) values('123_001_test_table.sql', 'Created test_table', 'kodecraft-pau');

   -- If everything is as expected, commit the transaction
   COMMIT;
   ```

7. **Test the Script in Test Environment**

   Before committing your script, it should be thoroughly tested in a test environment. This is to ensure that the script works as expected and does not introduce any new issues. The script should also be verified by a Quality Assurance engineer.
  
8. **Commit and Push the Script**

   After creating and testing your script, you need to commit it back to the database repository. This involves staging the script using `git add`, committing it with `git commit`, and then pushing it to the remote repository with `git push`.

   ```bash
   git add <your-script.sql>
   git commit -m "Add upgrade/fix script"
   git push origin ticket-<number>
   ```
   Replace `<your-script.sql>` and `<number>` with the actual name of your script and the ticket number, respectively.

9. **Create a Pull Request**

   Once you've pushed your changes to the remote repository, the next step is to create a pull request for code review. This is typically done on the GitHub website. Navigate to the repository on GitHub, switch to your branch, and click on "New pull request". Fill in the necessary details (title, description, reviewers, etc.) and then click "Create pull request".

10. **Execute the Script in Production**

   After your pull request has been reviewed and approved, you can now execute your script in the production environment. Make sure to follow any specific procedures your team has for this process to ensure minimal disruption and maximum data integrity.

   _Final Output:_
   
   ![image](https://github.com/kodecraft-pau/database/assets/155626785/479d680e-f9f0-46ee-8665-0313fdc1f80b)


