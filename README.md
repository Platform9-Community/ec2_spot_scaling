# ec2_spot_scaling
Demo of scaling the AWS CloudProvider PMK cluster up/down with spot instances

Set KUBECONFIG Env variable

```
export KUBECONFIG=/path/to/cluster.yaml
```

Note: These scaling actions take ~4-5 minutes before the nodes are fully converged.

Scale Up

```
make up
```

Scale Down

```
make down
```
