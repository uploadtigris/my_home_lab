### **1. Check Virtualization Support**

```bash
lscpu | grep -i virtualization
```

- Look for `VT-x` (Intel) or `AMD-V` (AMD). If missing, enable it in BIOS/UEFI.

---

### **2. Install KVM and Tools**

```bash
sudo dnf install -y @virtualization
```

This installs KVM, libvirt, `virt-manager` (GUI), and dependencies.

---

### **3. Start libvirtd and Add User**

```bash
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $(whoami)
```

- **Log out and back in** for group changes to apply.

---

### **4. Verify Installation**

```bash
lsmod | grep kvm
```

- Should show `kvm_intel` or `kvm_amd`.

---

### **5. Launch virt-manager**

```bash
virt-manager
```

- Use this GUI to create/manage VMs.

---

### **6. Verify Default Network**

```bash
virsh net-list --all
virsh net-start default && virsh net-autostart default
```