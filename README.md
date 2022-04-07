# ec2_spot_scaling
Demo of scaling the AWS CloudProvider PMK cluster up/down with spot instances

Set KUBECONFIG Env variable

```
export KUBECONFIG=/path/to/cluster.yaml
```

Scale Up

```
make up
```

Scale Down

```
make down
```
