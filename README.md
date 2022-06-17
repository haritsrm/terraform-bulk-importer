# Terraform Bulk Importer
Terraform state bulk importer and remover.

## Installation
- First we need to clone this repository: 
```shell
git clone https://github.com/rietzche/terraform-bulk-importer.git $HOME/Tools/terraform-state-importer
cd $HOME/Tools/terraform-state-importer
```
- Execute `./install.sh`
- Then go to your terraform project dir.
- Execute the command for the usage:
```shell
terraform-bulk-importer <DIR> <ARGS>
```
_Notes:_ 
- _`<DIR>` was a directory name on `$HOME/Tools/terraform-state-importer` that you would be created._
- _`<DIR>` must contain `modules` and `values` file, please look the `examples` folder on the repository._
- _`modules` is the list of module name that would be imported._ 
- _`values` is the list of parameters that depends on the modules._
- _`<ARGS>` is `-i` for importing and `-rm` for remove the imported state._

## Usages
You must create new directory on `$HOME/Tools/terraform-bulk-importer` for the `<DIR>` argument.

Add `modules` and `values` file for adding list of modules and params that would be imported into your project state.

Then run `terraform-bulk-importer <DIR> -i` for import and `terraform-bulk-importer <DIR> -rm` for remove imported state.

## Supports
For now this tool only support for UNIX machine.
