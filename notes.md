# JC Notes

So Broadway may have what you want built in.

*  Dynamic batching - Broadway allows developers to batch messages based on custom criteria. For example, if your pipeline needs to build batches based on the `user_id`, email address, etc, it can be done by calling `Broadway.Message.put_batch_key/2`.
* Ordering and Partitioning - Broadway allows developers to partition messages across workers, guaranteeing messages within the same partition are processed in order. For example, if you want to guarantee all events tied to a given `user_id` are processed in order and not concurrently, you can set the `:partition_by` option. See "Ordering and partitioning".

https://hexdocs.pm/broadway/Broadway.html#module-ordering-and-partitioning

yeah, "In the example above, we have set the same partition for all processors and batchers. You can also specify the `:partition_by` function for each "processor" and "batcher" individually." So you could have a different processor for each partition or batch and that would allow you to know where you are writing