unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
hi yamlBlockMappingKey guifg=#56B6C2
hi yamlKeyValueDelimiter guifg=#5e81ac
hi yamlDocumentStart guifg=#4FC1FF
hi yamlFlowCollection guifg=#4FC1FF
hi yamlPlainScalar guifg=#C678DD
hi yamlInteger guifg=#C678DD
hi yamlFrontmatter guifg=#C678DD
hi yamlFlowIndicator guifg=#98C379
