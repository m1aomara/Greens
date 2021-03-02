Render Farms/CDN
=================


A render farm is a computer system/data center which is specialized in the calculation of computer generated images (CGI). It's mainly used to create films, visual effects, as well as, architectural visualizations.
From the end-user perspective, a render farm is a service that puts a lot of computing power at his disposal, with the purpose of helping one deliver projects faster.

Each of the render nodes has the required 3D software, the renderer and needed plugins installed. Additionally, the hardware is optimized for CPU and GPU rendering.Larger render farms have up to thousands of render nodes.

.. figure:: images/renderservice.jpg
   :align: center
   :scale: 40 %

   High-Level Render Farm Service
   [Source - https://www.squidnetsoftware.com/workflow-render-farm-service/]

**How does a render farm work?**

Since a render farm has many render nodes, the frames of a 3D sequence can be calculated simultaneously on these nodes.
Taking the example we used before – if this sequence is calculated by one hundred render nodes instead of just one local system, 10 days of rendering shrink to 2.5 hours.
This makes it possible to reduce the rendering time notably.

.. figure:: images/render-cpu.jpg
   :align: center



**What kind of render farms exist?**

There are two types of render farms: **self-built** and **cloud based render farms** (commercial render farm).
If an artist has several computers at one's studio, one can use them to complete the rendering. In this case, one can consider about a self-built render farm. Larger studios may use hundreds of self-deployed servers to render a project. However, this requires a high level of technical skills for the setup and maintenance. Further costs arise for the hardware and software, manpower and energy.With a cloud based provider/commercial render farm, the user has the advantages of a render farm without all the costs for maintenance, hardware, software and energy costs. The user can start rendering right away, doesn't need high technical skills and thus will save money. Lastly, the greatest advantage is the speed of the rendering process, as well as, having the own computer available, while the project is rendered online.

**CDN**

Content delivery networks (CDN) are the transparent backbone of the Internet in charge of content delivery. Every one of us interacts with CDNs on a daily basis; when reading articles on news sites, shopping online, watching YouTube videos or perusing social media feeds.
No matter what one do, or what type of content one consumes, chances are that one will find CDNs behind every character of text, every image pixel and every movie frame that gets delivered to your PC and mobile browser.
To understand why CDNs are so widely used, one first needs to recognize the issue CDNs designed to solve. Known as latency, it’s the annoying delay that occurs from the moment you request to load a web page to the moment its content actually appears onscreen.
That delay interval is affected by a number of factors, many being specific to a given web page. In all cases however, the delay duration is impacted by the physical distance between you and that website’s hosting server.
A CDN’s mission is to virtually shorten that physical distance, the goal being to improve site rendering speed and performance.

.. figure:: images/cdn.png
   :align: center


**How a CDN Works?**

To minimize the distance between the visitors and your website’s server, a CDN stores a cached version of its content in multiple geographical locations (a.k.a., points of presence, or PoPs). Each PoP contains a number of caching servers responsible for content delivery to visitors within its proximity.
In essence, CDN puts your content in many places at once, providing superior coverage to your users. For example, when someone in London accesses your US-hosted website, it is done through a local UK PoP. This is much quicker than having the visitor’s requests, and your responses, travel the full width of the Atlantic and back.


References -

https://www.cloudflare.com/learning/cdn/what-is-a-cdn/
https://gb.rebusfarm.net/en/

