<script>
  import Tailwindcss from "./Tailwindcss.svelte";
  import Service from './Service.svelte'

  export let name;
</script>

<style>
  main {
    text-align: center;
    padding: 1em;
    margin: 0 auto;
  }
</style>

<Tailwindcss />
<main>
  <h1 class="text-2xl">
    How is the Cloud?
  </h1>
  <h3 class="text-lg">
    Stop being gaslit by ___ status pages and find out if critical cloud services are down using real API calls.
  </h3>
  <div class="flex justify-between">
    <Service name="Docker Hub"/>
    <Service name="Cloudflare"/>
    <Service name="Amazon S3"/>
    <Service name="GitHub"/>
  </div>
</main>
