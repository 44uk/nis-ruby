## root page

```ruby
nis = Nis.new(host: '23.228.67.85')

p nis.namespace_root_page
```

## mosaic definition page

```ruby
nis = Nis.new(host: '23.228.67.85')

p nis.namespace_mosaic_definition_page(namespace: 'alice.misc')
```
