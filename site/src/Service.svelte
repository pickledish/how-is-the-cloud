<script>

	import dayjs from 'dayjs'

	import { getService } from './dynamodb.js'

	export let name;
	export let command;
	export let darker;
	export let top = false;

	let safeName = name.toLowerCase().replaceAll(' ', '_')
	let promise = getService(safeName);

</script>

<div class="h-14 shadow-md flex justify-between items-center my-2 px-3 py-2 bg-white rounded-md">
	<div class="w-10">
		<div class="h-6 w-6 border ml-1"></div>
		<!--<img src="./docker_hub.png"/>-->
	</div>
	<div class="w-28">
		<div class="font-bold">{name}</div>
	</div>
	<div class="flex-grow font-mono text-sm">
		{command}
	</div>
	{#await promise}
	<div>
		waiting...
	</div>
	{:then service}
	<div>
		<p class="text-gray-600 text-sm mt-1">Checked {dayjs.unix(service.CheckTime).format('HH:mm:ss')}</p>
	</div>
	<div>
		<svg class="fill-current w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
			<path d="M12 0c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm-1.25 17.292l-4.5-4.364 1.857-1.858 2.643 2.506 5.643-5.784 1.857 1.857-7.5 7.643z"/>
		</svg>
	</div>
	{:catch error}
		<p style="color: red">{error.message}</p>
	{/await}
</div>
