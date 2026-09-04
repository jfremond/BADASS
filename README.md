# BADASS - BGP At Doors of Autonomous Systems is Simple

> A 42 network administration project where we simulate a small data center
> network with **GNS3**, **Docker**, **VXLAN**, and **BGP EVPN**.

## 📖 Overview

The purpose of this project is to extend the knowledge gained through
NetPractice by asking us to simulate a network and configure it using **GNS3**
with **docker** images.


BGP EVPN is based on BGP ([RFC 4271](https://datatracker.ietf.org/doc/rfc4271/))
and its extensions, MP-BGP
([RFC 4760](https://datatracker.ietf.org/doc/rfc4760/)).
BGP is the routing protocol that drives the Internet.

Through MP-BGP extensions, it can be used to carry reachability information
(NLRI) for various protocols (IPv4, IPv6, L3 VPN and in this case, EVPN).

EVPN is a special family used for publishing information about MAC addresses and
the end devices that access them.

## 🎯 Objectives

-   Install and configure **GNS3** and **Docker** in a virtual machine.
-   Build two custom Docker images (a lightweight host image and a
router/routing-daemon image).
-   Deploy and connect containers inside GNS3.
-   Build a **VXLAN** ([RFC 7348](https://datatracker.ietf.org/doc/rfc7348/))
overlay network, first statically, then with dynamic multicast.
-   Build a small **BGP EVPN**
([RFC 7432](https://datatracker.ietf.org/doc/rfc7432/)) fabric
(**route reflector** + **VTEP** leaves) that automatically learns MAC
addresses over the VXLAN, without **MPLS**.


## 📚 Lexicon

**BGP (Border Gateway Protocol)**

BGP is the routing protocol that holds the internet together. It is how
autonomous systems tell each other they can reach a range of IP addresses.

**MP-BGP (Multiprotocol BGP)**

This is an extension of BGP. Plain BGP only carries IPv4 route info. MP-BGP lets
BGP carry IPv6 routes, VPN routes and MAC address info for EVPN.

**EVPN (Ethernet VPN)**

EVPN is built on MP-BGP and its purpose is to advertise MAC addresses and which
device/location they're reachable behind, instead of IP prefixes. It is how the
routers learn the location of other devices automatically over BGP, instead of
flooding on every switch.

Route types of EVPN:
-   Type 2: MAC advertisement route, advertises that a specific MAC address
lives behind a given VTEP. It is automatically created the moment a host's
traffic is seen.

-   Type 3: Inclusive Multicast route, a VTEP announcing itself for a given VNI.
It is present as soon as the VXLAN/BGP session is up, even before any host is
active.

**VXLAN (Virtual eXtensible LAN)**

VXLAN lets us create a virtual Layer-2 network across a Layer-3 network. It is
how two machines can be on the same Ethernet LAN even though there are routers
between them.

Key pieces of VXLAN:
-   VNI (VXLAN Network Identifier)

It is what identifies a VXLAN. It is how multiple VXLAN networks can run over
the same physical infrastructure without getting their traffic mixed
-   VTEP (VXLAN Tunnel Endpoint)

It is what wraps Ethernet frames into VXLAN packets on the way out and unwraps
them on the way in

**Bridge**

It is what connects the local interface and the VXLAN interface together

**Route Reflector**

It is what reflects the routes from one client to the others

**OSPF (Open Shortest Path First)**

It is what gives routers accessibility to each other's loopback address so the
BGP sessions and VXLAN tunnels have something to run over.

**IS-IS**

It is a routing protocol similar to OSPF. Required as a service but OSPF is what
is acutally used