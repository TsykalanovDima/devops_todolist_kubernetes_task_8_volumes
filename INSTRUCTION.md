# Validation Instructions

## Prerequisites

- A running Kubernetes cluster (e.g. minikube, kind, or a cloud cluster)
- `kubectl` configured to point at that cluster

## Deploy

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

---

## 1. Verify the App is Running

Check that all pods in the `todoapp` namespace are in `Running` state and both liveness and readiness probes pass:

```bash
kubectl get pods -n todoapp
```

Expected output — all pods should show `Running` with `READY` showing `1/1`:

```
NAME                       READY   STATUS    RESTARTS   AGE
todoapp-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
todoapp-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
```

To check the deployment rollout status:

```bash
kubectl rollout status deployment/todoapp -n todoapp
```

To hit the app via the NodePort service (replace `<NODE_IP>` with your node's IP, e.g. `minikube ip`):

```bash
curl http://<NODE_IP>:30007/api/health
```

Expected response: HTTP `200 OK`.

---

## 2. Verify ConfigMap Data is Mounted as Files

The ConfigMap (`app-config`) should be mounted as individual files inside `/app/configs` in the container. Each key in the ConfigMap becomes a separate file.

First, get a pod name:

```bash
POD=$(kubectl get pod -n todoapp -l app=todoapp -o jsonpath="{.items[0].metadata.name}")
```

List files in the configs directory:

```bash
kubectl exec -n todoapp $POD -- ls /app/configs
```

Expected output:

```
PYTHONUNBUFFERED
```

Read the file content to confirm the value:

```bash
kubectl exec -n todoapp $POD -- cat /app/configs/PYTHONUNBUFFERED
```

Expected output:

```
1
```

---

## 3. Verify Secret Data is Mounted as a File

The Secret (`app-secret`) should be mounted as individual files inside `/app/secrets` in the container. Each secret key becomes a separate file.

List files in the secrets directory:

```bash
kubectl exec -n todoapp $POD -- ls /app/secrets
```

Expected output:

```
SECRET_KEY
```

Read the file content to confirm the secret is present:

```bash
kubectl exec -n todoapp $POD -- cat /app/secrets/SECRET_KEY
```

Expected output: the decoded secret key value (a long string starting with `@e2...`).

---

## 4. Verify PersistentVolume is Bound

```bash
kubectl get pv todoapp-pv
kubectl get pvc todoapp-pvc -n todoapp
```

Both should show `STATUS: Bound`.