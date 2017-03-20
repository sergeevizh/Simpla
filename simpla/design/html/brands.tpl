{* Вкладки *}
{capture name=tabs}
	{if in_array('products', $manager->permissions)}
		<li>
			<a href="index.php?module=ProductsAdmin">Товары</a>
		</li>
	{/if}
	{if in_array('categories', $manager->permissions)}
		<li>
			<a href="index.php?module=CategoriesAdmin">Категории</a>
		</li>
	{/if}
	<li class="active">
		<a href="index.php?module=BrandsAdmin">Бренды</a>
	</li>
	{if in_array('features', $manager->permissions)}
		<li>
			<a href="index.php?module=FeaturesAdmin">Свойства</a>
		</li>
	{/if}
{/capture}

{* Title *}
{$meta_title='Бренды' scope=root}

{* Заголовок *}
<div id="header">
	<h1>Бренды</h1>
	<a class="add" href="{url module=BrandAdmin return=$smarty.server.REQUEST_URI}">Добавить бренд</a>
</div>

{if $brands}
	<div id="main_list" class="brands">

		<form id="list_form" method="post">
			<input type="hidden" name="session_id" value="{$smarty.session.id}">

			<div id="list" class="brands">
				{foreach $brands as $brand}
					<div class="row">
						<div class="checkbox cell">
							<input type="checkbox" name="check[]" value="{$brand->id}"/>
						</div>
						<div class="cell">
							<a href="{url module=BrandAdmin id=$brand->id return=$smarty.server.REQUEST_URI}">{$brand->name|escape}</a>
						</div>
						<div class="icons cell">
							<a class="preview" title="Предпросмотр в новом окне" href="../brands/{$brand->url}" target="_blank"></a>
							<a class="delete" title="Удалить" href="#"></a>
						</div>
						<div class="clear"></div>
					</div>
				{/foreach}
			</div>

			<div id="action">
				<label id="check_all" class="dash_link">Выбрать все</label>

				<span id="select">
					<select name="action">
						<option value="delete">Удалить</option>
					</select>
				</span>
				<input id="apply_action" class="button_green" type="submit" value="Применить">
			</div>

		</form>
	</div>
{else}
	Нет брендов
{/if}

{literal}
	<script>
		$(function () {
			// Раскраска строк
			$("#list div.row").colorize();

			// Выделить все
			$("#check_all").click(function () {
				$('#list input[type="checkbox"][name*="check"]').attr('checked', $('#list input[type="checkbox"][name*="check"]:not(:checked)').length > 0);
			});

			// Удалить
			$("a.delete").click(function () {
				$('#list input[type="checkbox"][name*="check"]').attr('checked', false);
				$(this).closest("div.row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
				$(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
				$(this).closest("form").submit();
			});

			// Подтверждение удаления
			$("form").submit(function () {
				if ($('#list input[type="checkbox"][name*="check"]:checked').length > 0)
					if ($('select[name="action"]').val() == 'delete' && !confirm('Подтвердите удаление'))
						return false;
			});

		});
	</script>
{/literal}
