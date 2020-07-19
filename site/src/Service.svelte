<script>

	export let name;

</script>

<div class="w-48 h-48 border-solid border-4 border-gray-600 flex flex-col justify-between items-stretch px-3 py-2">
	<div class="flex justify-between items-center mb-2">
		<div class="font-bold">{name}</div>
		<svg class="fill-current w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
			<path d="M12 0c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm-1.25 17.292l-4.5-4.364 1.857-1.858 2.643 2.506 5.643-5.784 1.857 1.857-7.5 7.643z"/>
		</svg>
	</div>
	<div class="flex-auto min-h-0 min-w-0 px-2">
		<!--<img src="{name.toLowerCase().replaceAll(' ', '_')}.png"/>-->
		IMAGE
	</div>
	<div>
		<p class="text-gray-600 text-sm">Checked 10:31:22 PM</p>
	</div>
</div>
