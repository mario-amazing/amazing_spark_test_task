# README
## Usage

After setup application(bundle db etc.) you could run rails server:
` cd $WORK_DIR && rails c`

Then you could go to:
```http://localhost:3000/admin/upload_csv_files```
And then click `Upload` .csv product file.
You can take valid and invalid examples form Rails app as well:
```
Rails.root + 'spec/fixtures/csv/products/valid_product_file.csv
Rails.root + 'spec/fixtures/csv/products/invalid_product_file.csv
```
Then you'll see your csv files in upload table. 
And Sidekiq will perform files async and will propagate status to table.

More comments you can find in the project.

Thank in advance for your time :)
