global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
    region2 = "centralus"
    region3 = "westeurope"
  }
}

resource_groups = {
  batch_region1 = {
    name = "batch"
  }
}

batch_accounts = {
  batch1 = {
    name               = "batch"
    resource_group_key = "batch_region1"
  }
}

batch_pools = {
  pool1 = {
    name              = "batch"
    batch_account_key = "batch1"
    node_agent_sku_id = "batch.node.ubuntu 20.04"
    vm_size           = "Standard_A1"

    storage_image_reference = {
      publisher = "microsoft-azure-batch"
      offer     = "ubuntu-server-container"
      sku       = "20-04-lts"
      version   = "latest"
    }

    auto_scale = {
      evaluation_interval = "PT15M"
      formula             = <<EOF
        startingNumberOfVMs = 1;
        maxNumberofVMs = 5;
        pendingTaskSamplePercent = $PendingTasks.GetSamplePercent(180 * TimeInterval_Second);
        pendingTaskSamples = pendingTaskSamplePercent < 70 ? startingNumberOfVMs : avg($PendingTasks.GetSample(180 *   TimeInterval_Second));
        $TargetDedicatedNodes=min(maxNumberofVMs, pendingTaskSamples);
  EOF
    }
  }
}

batch_jobs = {
  job1 = {
    name           = "job1"
    batch_pool_key = "pool1"
  }
}
