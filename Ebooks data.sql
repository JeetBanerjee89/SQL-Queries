SELECT ebook_batches.ebook_id as "E-book ID",
      ebooks.display_name as "E-book Display Name",
      ebooks.name as "E-book Name",
      ebooks.no_of_pages as "n(pages)",
      ebooks.sort_sequence as "E-book Sequence",
      ebooks.is_publish as "Is E-book Published?",
      ebook_categories.id as "E-book Category ID",
      ebook_categories.category_id as "Category ID",
      categories.name as "Category Name",
      categories.is_active as "Is Category Active?",
      ebook_batches.batch_id as "TLLMS Batch ID",
      batches.name as "TLLMS Batch Name",
      ebook_batches.status as "Is TLLMS Batch Active?",
      batches.cohort_id as "Cohort ID"
     
FROM ebook_batches /*Base Table*/
    JOIN ebooks ON ebooks.id=ebook_batches.ebook_id /*Joining "ebooks" table with "ebook_batches" table with common parameter*/
    JOIN batches ON batches.id=ebook_batches.batch_id /*Joining "batches" table with "ebook_batches" table with common parameter*/
    JOIN ebook_categories ON ebook_categories.ebook_id=ebook_batches.ebook_id /*Linking "ebook_categories" with "ebook_batches" first*/
    JOIN categories ON categories.id=ebook_categories.category_id /*Now, linking "categories" with "ebook_categories"*/
where ebook_batches.ebook_id IN ({{Enter E-book Id(s)}}) /*User input*/
ORDER BY ebook_batches.ebook_id asc /*Ascending order by ebook_id*/
