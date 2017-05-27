{include file="inc/head.tpl"}
<div class="wrapper">
<div itemscope itemtype="http://schema.org/VideoObject">
<div class="main">
{include file="inc/logo.tpl"}
<p id="download_intro">{t}You are going to download{/t}<i itemprop="name">
    <a itemprop="url" id="video_link"
        data-ext="{$video->ext}"
        data-video="{$video->url|escape}"
        href="{$video->webpage_url}">
{$video->title}</a></i>.
</p>
{if isset($video->thumbnail)}
    <img itemprop="thumbnailUrl" class="thumb" src="{$video->thumbnail}" alt="" />
{/if}
{if isset($video->description)}
    <meta itemprop="description" content="{$video->description|escape}" />
{/if}
{if isset($video->upload_date)}
    <meta itemprop="uploadDate" content="{$video->upload_date}" />
{/if}
<br/>
{if isset($video->formats)}
    <h3><label for="format">{t}Available formats:{/t}</label></h3>
    <form action="{path_for name="redirect"}">
        <input type="hidden" name="url" value="{$video->webpage_url}" />
        {if $uglyUrls}
            <input type="hidden" name="page" value="redirect" />
        {/if}
        <select name="format" id="format" class="formats monospace">
            <optgroup label="{t}Generic formats{/t}">
                <option value="best{$protocol}">
                    {strip}
                        {t}Best{/t} ({$video->ext})
                    {/strip}
                </option>
                {if $remux}
                    <option value="bestvideo+bestaudio">
                        {t}Remux best video with best audio{/t}
                    </option>
                {/if}
                <option value="worst{$protocol}">
                    {t}Worst{/t}
                </option>
            </optgroup>
            <optgroup label="{t}Detailed formats{/t}" class="monospace">
                {foreach $video->formats as $format}
                    {if $config->stream || $format->protocol|in_array:array('http', 'https')}
                        {strip}
                        <option value="{$format->format_id}">
                            {$format->ext}
                            {for $foo=1 to (5 - ($format->ext|strlen))}
                                &nbsp;
                            {/for}
                            {if isset($format->width)}
                                {$format->width}x{$format->height}
                                {for $foo=1 to (10 - (("{$format->width}x{$format->height}")|strlen))}
                                    &nbsp;
                                {/for}
                            {else}
                                {for $foo=1 to 10}
                                    &nbsp;
                                {/for}
                            {/if}
                            {if isset($format->filesize)}
                                {($format->filesize/1000000)|round:2} MB
                                {for $foo=1 to (7 - (($format->filesize/1000000)|round:2|strlen))}
                                    &nbsp;
                                {/for}
                            {else}
                                {for $foo=1 to 10}
                                    &nbsp;
                                {/for}
                            {/if}
                            {if isset($format->format_note)}
                                {$format->format_note}
                            {/if}
                            &nbsp;({$format->format_id})
                        </option>
                        {/strip}
                    {/if}
                {/foreach}
            </optgroup>
        </select><br/><br/>
        <input class="downloadBtn" type="submit" value="{t}Download{/t}" /><br/>
    </form>
{else}
    <input type="hidden" name="format" value="best{$protocol}" />
    <a class="downloadBtn"
        href="{$video->url|escape}">{t}Download{/t}</a><br/>
{/if}
</div>
</div>
{include file="inc/footer.tpl"}
