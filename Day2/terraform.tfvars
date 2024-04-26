####################
# Common Variables #
####################
prefix = "STELLA"
RESOURCE_LOCATION = "Centralus"
APP_ENV = "DEV"
APP_NAME = "Stella"

##################
# Authentication #
##################

ARM_SUBSCRIPTION_ID = "c236257f-1483-4eb8-a335-52d37d67b08e"

###########
# Network #
###########
network-vnet-cidr   = "10.128.0.0/16"
network-subnet-cidr = "10.128.1.0/24"


##################
# VM Information #
##################
linux_vm_size        = "Standard_F2"
linux_admin_username = "Adminuser"
linux_admin_password="Boathead@789"

############
# RHEL Information #
############
linux_vm_image_publisher="RedHat"
linux_vm_image_offer="RHEL"
rhel_sku_image = "8_5"