<script>
  import Tailwindcss from "./Tailwindcss.svelte";
  import Service from './Service.svelte'

  export let name;
</script>

<Tailwindcss />

<main class="w-full px-2 md:px-32">
  <h1 class="text-4xl mb-4">
    How is the cloud doing?
  </h1>
  <h3 class="text-xl mb-4">
    Stop being gaslit by ___ status pages and find out if critical cloud services are down via real API calls.
  </h3>
  <div class="w-full flex justify-center">
    <div class="flex flex-col justify-between items-stretch w-full md:w-10/12">
      <Service name="Docker Hub" command="coming soon"/>
      <Service name="Cloudflare" command=""/>
      <Service name="GitHub" command="git clone https://github.com/airbnb/javascript.git"/>
      <Service name="Amazon S3" command="curl https://noaa-gfs-bdp-pds.s3.amazonaws.com/index.html"/>
      <Service name="PyPI" command="pip install requests==2.24.0"/>
    </div>
  </div>
</main>
