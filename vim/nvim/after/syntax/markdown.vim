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

" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
