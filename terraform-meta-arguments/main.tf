resource "local_file" "demo-count" {
  filename = var.demo-count-filename[count.index]
  count    = length(var.demo-count-filename)
  content  = "Demo txt file"
}

resource "local_file" "demo-foreach"{
    filename = each.value
    for_each = toset(var.demo-foreach-filename)
    content = "for_each demo"
}