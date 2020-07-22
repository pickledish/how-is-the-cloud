<script>

	import dayjs from 'dayjs'

	import { getService } from './dynamodb.js'

	export let name;
	export let command;

	let safeName = name.toLowerCase().replaceAll(' ', '_')
	let promise = getService(safeName);

</script>

<div class="h-14 shadow-md flex justify-between items-center my-2 px-5 py-2 bg-white rounded-md">
	<div class="w-8 mr-6">
		<img class="h-8 w-8" src="./{safeName}.png"/>
	</div>
	<div class="w-30">
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
		<p class="text-gray-600 text-sm pr-4">{dayjs.unix(service.CheckTime).format('h:mm A')}</p>
	</div>
	<div>
		{#if service.Success}
		<svg
			xmlns="http://www.w3.org/2000/svg"
			class="icon icon-tabler text-green-500"
			width="24"
			height="24"
			viewBox="0 0 24 24"
			stroke-width="2.5"
			stroke="currentColor"
			fill="none"
			stroke-linecap="round"
			stroke-linejoin="round"
		>
			<path stroke="none" d="M0 0h24v24H0z"/>
			<circle cx="12" cy="12" r="9" />
			<path d="M9 12l2 2l4 -4" />
		</svg>
		{:else}
		<svg
			xmlns="http://www.w3.org/2000/svg"
			class="icon icon-tabler text-red-600"
			width="24"
			height="24"
			viewBox="0 0 24 24"
			stroke-width="2.5"
			stroke="currentColor"
			fill="none"
			stroke-linecap="round"
			stroke-linejoin="round"
		>
			<path stroke="none" d="M0 0h24v24H0z"/>
			<circle cx="12" cy="12" r="9" />
			<path d="M10 10l4 4m0 -4l-4 4" />
		</svg>
		{/if}
	</div>
	{:catch error}
		<p style="color: red">{error.message}</p>
	{/await}
</div>
