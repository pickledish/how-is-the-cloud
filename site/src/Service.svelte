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

<div class="h-14 shadow-md flex justify-between items-center my-2 px-4 py-2 bg-white rounded-md">
	<div class="w-6 mr-4">
		<img class="h-6 w-6" src="./{safeName}.png"/>
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
		<p class="text-gray-600 text-sm pr-4">{dayjs.unix(service.CheckTime).format('HH:mm:ss')}</p>
	</div>
	<div>
		{#if service.Success}
		<img style="color:red;" src="icons/circle-check.svg" alt="Check succeeded"/>
		{:else}
		<img src="icons/circle-x.svg" alt="Check has issues"/>
		{/if}
	</div>
	{:catch error}
		<p style="color: red">{error.message}</p>
	{/await}
</div>
